from flask import request, jsonify
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from models.user_model import User
from __init__ import db, bcrypt, jwt
from datetime import timedelta

def register():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')
    user_type = data.get('user_type')
    nid = data.get('nid')
    email = data.get('email')
    phone = data.get('phone')
    car_type = data.get('car_type')
    license_plate_number = data.get('license_plate_number')
    driving_license_number = data.get('driving_license_number')

    if not username or not password or not user_type or not email or not phone:
        return jsonify({'message': 'Missing required fields'}), 400

    if user_type == 'VehicleOwner' and not nid:
        return jsonify({'message': 'NID is required for VehicleOwner'}), 400

    if User.query.filter_by(username=username).first():
        return jsonify({'message': 'Username already exists'}), 400

    hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
    new_user = User(
        username=username,
        password=hashed_password,
        user_type=user_type,
        nid=nid,
        email=email,
        phone=phone,
        car_type=car_type if user_type == 'VehicleOwner' else None,
        license_plate_number=license_plate_number if user_type == 'VehicleOwner' else None,
        driving_license_number=driving_license_number if user_type == 'VehicleOwner' else None
    )
    db.session.add(new_user)
    db.session.commit()

    return jsonify({'message': 'User registered successfully'}), 201

def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    user = User.query.filter_by(username=username).first()
    if user and bcrypt.check_password_hash(user.password, password):
        access_token = create_access_token(
            identity={
                'username': user.username,
                'user_type': user.user_type
            },
            expires_delta=timedelta(hours=1)
        )
        return jsonify({'access_token': access_token, 'user_type': user.user_type}), 200
    else:
        return jsonify({'message': 'Invalid credentials'}), 401