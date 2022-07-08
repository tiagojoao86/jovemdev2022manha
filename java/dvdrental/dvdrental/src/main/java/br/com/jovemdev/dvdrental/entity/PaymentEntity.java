package br.com.jovemdev.dvdrental.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@NoArgsConstructor
@Getter
@Entity
@Table(name = "payment")
public class PaymentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "payment_id_generator")
    @SequenceGenerator(name="payment_id_generator",
            sequenceName = "payment_payment_id_seq",
            allocationSize = 1)
    @Column(name = "payment_id")
    private Long id;

    @Column(name = "customer_id")
    private Long customerId;

    @JsonIgnore
    @ManyToOne()
    @JoinColumn(name = "staff_id", referencedColumnName = "staff_id")
    private StaffEntity staffEntity;

    @Column(name = "rental_id")
    private Long rentalId;

    @Column(name = "amount")
    private BigDecimal amount;

    @Column(name = "payment_date")
    private LocalDateTime paymentDate;

    public PaymentEntity(Long id, Long customerId, StaffEntity staffEntity,
                         Long rentalId, BigDecimal amount, LocalDateTime paymentDate) {
        this.id = id;
        this.customerId = customerId;
        this.staffEntity = staffEntity;
        this.rentalId = rentalId;
        this.amount = amount;
        this.paymentDate = paymentDate;
    }
}
