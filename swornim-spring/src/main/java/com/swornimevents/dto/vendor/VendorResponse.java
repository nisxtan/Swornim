package com.swornimevents.dto.vendor;

import com.swornimevents.model.VendorStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class VendorResponse {
    private Long id;
    private String name;
    private String description;
    private String contactEmail;
    private String phoneNumber;
    private String address;
    private VendorStatus status;
    private Long userId;
} 