package com.swornimevents.repository;

import com.swornimevents.model.Vendor;
import com.swornimevents.model.VendorStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VendorRepository extends JpaRepository<Vendor, Long> {
    List<Vendor> findByStatus(VendorStatus status);
    boolean existsByContactEmail(String email);
} 