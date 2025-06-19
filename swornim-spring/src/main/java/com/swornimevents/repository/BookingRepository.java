package com.swornimevents.repository;

import com.swornimevents.model.AppUser;
import com.swornimevents.model.Booking;
import com.swornimevents.model.BookingStatus;
import com.swornimevents.model.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {
    List<Booking> findByUser(AppUser user);
    List<Booking> findByEvent(Event event);
    List<Booking> findByStatus(BookingStatus status);
    List<Booking> findByUserAndStatus(AppUser user, BookingStatus status);
} 