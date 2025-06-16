package com.swornimevents.repository;

import com.swornimevents.model.Event;
import com.swornimevents.model.EventStatus;
import com.swornimevents.model.Vendor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface EventRepository extends JpaRepository<Event, Long> {
    List<Event> findByVendor(Vendor vendor);
    List<Event> findByStatus(EventStatus status);
    List<Event> findByStartTimeAfter(LocalDateTime dateTime);
    List<Event> findByVendorAndStatus(Vendor vendor, EventStatus status);
} 