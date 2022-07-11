package br.com.jovemdev.dvdrental.service;

import br.com.jovemdev.dvdrental.entity.StaffEntity;

import java.util.List;

public interface StaffEntityService {
    List<StaffEntity> findAll();
    StaffEntity save(StaffEntity staffEntity);
    List<StaffEntity> findByFirstNameIgnoreCase(String nome);
}
