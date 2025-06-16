package com.swornimevents.dto.booking;

import com.swornimevents.model.BookingStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BookingResponse {
    private Long id;
    private Long userId;
    private String userName;
    private Long eventId;
    private String eventName;
    private LocalDateTime bookingDate;
    private Integer numberOfTickets;
    private Double totalAmount;
    private BookingStatus status;
    private String paymentId;
    private LocalDateTime paymentDate;
} 