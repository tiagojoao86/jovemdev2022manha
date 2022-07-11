package br.com.jovemdev.dvdrental.repository;

import br.com.jovemdev.dvdrental.entity.StaffEntity;

import java.util.List;

public interface StaffEntityRepositoryCustom {

    List<StaffEntity> listarPorPrimeiroNome(String nome);
}
