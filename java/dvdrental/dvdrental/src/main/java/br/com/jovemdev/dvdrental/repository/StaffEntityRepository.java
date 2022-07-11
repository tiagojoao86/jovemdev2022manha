package br.com.jovemdev.dvdrental.repository;

import br.com.jovemdev.dvdrental.entity.StaffEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StaffEntityRepository extends JpaRepository<StaffEntity, Long>, StaffEntityRepositoryCustom {
    List<StaffEntity> findByFirstNameContainsIgnoreCase(String nome);

    @Query(value = "SELECT * FROM staff WHERE first_name ilike concat('%', ?1, '%')", nativeQuery = true)
    List<StaffEntity> buscarPeloPrimeirNomeSql(String nome);

    @Query(value = "SELECT s FROM StaffEntity s WHERE lower(s.firstName) like lower(concat('%', ?1, '%'))")
    List<StaffEntity> buscarPeloPrimeirNomeJpql(String nome);

}
