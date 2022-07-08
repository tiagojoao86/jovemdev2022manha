package br.com.jovemdev.dvdrental.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@NoArgsConstructor
@Getter
@Entity
@Table(name = "staff")
public class StaffEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "staff_id_generator")
    @SequenceGenerator(name="staff_id_generator",
            sequenceName = "staff_staff_id_seq",
            allocationSize = 1)
    @Column(name = "staff_id")
    private Long id;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "email")
    private String email;

    @Column(name = "active")
    private Boolean active;

    @Column(name = "username")
    private String username;

    @Column(name = "password")
    private String password;

    @Column(name = "last_update", insertable = false)
    private LocalDateTime lastUpdate;

    @Column(name = "picture")
    private Byte[] picture;

    /*
    @Column(name = "address_id")
    private Long addressId;*/

    @ManyToOne
    @JoinColumn(name = "address_id", referencedColumnName = "address_id")
    private AddressEntity addressEntity;

    @OneToMany(mappedBy = "staffEntity")
    private List<PaymentEntity> payments;

    @Column(name = "store_id")
    private Long storeId;

    public StaffEntity(Long id, String firstName, String lastName, String email, Boolean active,
                       String username, String password, Byte[] picture,
                       Long storeId) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.active = active;
        this.username = username;
        this.password = password;
        this.picture = picture;
        this.storeId = storeId;
    }
}
