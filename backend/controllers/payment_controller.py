from flask import request, jsonify
import requests
from models.payment_model import Payment
from models.booking_model import Booking
from __init__ import db
from datetime import datetime

def process_payment():
    data = request.get_json()

    # Validate required fields
    required_fields = ['booking_id', 'amount', 'vehicle_owner']
    if not all(field in data for field in required_fields):
        return jsonify({'message': 'Missing required fields.'}), 400

    # Check if the booking exists
    booking = Booking.query.filter_by(booking_id=data['booking_id']).first()
    if not booking:
        return jsonify({'message': 'Booking not found.'}), 404

    # Create a new payment record
    new_payment = Payment(
        transaction_id=f"PAY_{datetime.now().strftime('%Y%m%d%H%M%S')}",  # Generate a unique transaction ID
        booking_id=data['booking_id'],
        amount=data['amount'],
        status='Completed',  # Simulate a successful payment for now
        refund_status='Pending'
    )

    db.session.add(new_payment)
    db.session.commit()

    return jsonify({'message': 'Payment processed successfully.', 'transaction_id': new_payment.transaction_id}), 201

def process_sslcommerz_payment_logic(amount, booking_id, vehicle_owner):
    # Set up SSLCommerz API URL for initiating payment
    url = "https://sandbox.sslcommerz.com/gwprocess/v4/api.php"  # Use the LIVE URL in production
    payload = {
        "store_id": "parkk67bde9fc11501",  # Replace with your store id
        "store_passwd": "parkk67bde9fc11501@ssl",  # Replace with your store password
        "total_amount": amount,
        "currency": "BDT",
        "tran_id": f"BOOK_{booking_id}_{datetime.now().strftime('%Y%m%d%H%M%S')}",
        "product_category": "Parking",
        "multi_card_name": "visa,master,bkash",  # Cards that are supported by SSLCommerz
        "cus_name": vehicle_owner['username'],  # Using the vehicle owner's username
        "cus_email": vehicle_owner['email'],  # Vehicle owner's email
        "cus_phone": vehicle_owner['phone'],  # Vehicle owner's phone number
        "cus_add1": "Address Not Provided",  # You can add more information if available
        "cus_city": "Dhaka",  # Default city; you may change based on user information
        "cus_postcode": "1200",  # Default postal code; update if applicable
        "cus_country": "Bangladesh"  # Vehicle owner's country (assuming Bangladesh)
    }

    try:
        # Send the payment request to SSLCommerz
        response = requests.post(url, data=payload)
        response_data = response.json()

        # Handle the response from SSLCommerz
        if response_data.get('status') == 'SUCCESS':
            # Payment was successful, return a unique transaction ID
            return True, response_data['tran_id']
        else:
            # Payment failed, return an error message
            return False, response_data.get('message', 'Payment failed')

    except requests.exceptions.RequestException as e:
        # Handle any errors during the API call
        return False, str(e)


def initiate_refund(transaction_id):
    payment = Payment.query.filter_by(transaction_id=transaction_id).first()
    if not payment:
        return jsonify({'message': 'Payment not found.'}), 404

    # Check if the payment is eligible for a refund
    if payment.status != 'Completed':
        return jsonify({'message': 'Payment is not eligible for a refund.'}), 400

    # Update refund status
    payment.refund_status = 'Completed'  # Simulate a successful refund for now
    db.session.commit()

    return jsonify({'message': 'Refund initiated successfully.'}), 200

def get_payment_details(transaction_id):
    payment = Payment.query.filter_by(transaction_id=transaction_id).first()
    if not payment:
        return jsonify({'message': 'Payment not found.'}), 404

    payment_details = {
        'transaction_id': payment.transaction_id,
        'booking_id': payment.booking_id,
        'amount': float(payment.amount),
        'status': payment.status,
        'transaction_date': payment.transaction_date.isoformat(),
        'refund_status': payment.refund_status
    }

    return jsonify(payment_details), 200