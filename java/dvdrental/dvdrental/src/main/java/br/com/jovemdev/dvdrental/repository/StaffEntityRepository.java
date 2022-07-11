package br.com.jovemdev.dvdrental.repository;

import br.com.jovemdev.dvdrental.entity.StaffEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StaffEntityRepository extends JpaRepository<StaffEntity, Long> {
    List<StaffEntity> findByFirstNameIgnoreCase(String nome);
}
