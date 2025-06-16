package com.swornimevents.service;

import com.swornimevents.dto.auth.AuthenticationRequest;
import com.swornimevents.dto.auth.AuthenticationResponse;
import com.swornimevents.dto.auth.RegisterRequest;

public interface AuthenticationService {
    AuthenticationResponse register(RegisterRequest request);
    AuthenticationResponse authenticate(AuthenticationRequest request);
} 