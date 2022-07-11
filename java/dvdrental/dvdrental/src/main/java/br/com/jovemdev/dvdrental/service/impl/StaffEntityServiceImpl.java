package br.com.jovemdev.dvdrental.service.impl;

import br.com.jovemdev.dvdrental.entity.StaffEntity;
import br.com.jovemdev.dvdrental.repository.StaffEntityRepository;
import br.com.jovemdev.dvdrental.service.StaffEntityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StaffEntityServiceImpl implements StaffEntityService {

    @Autowired
    private StaffEntityRepository repository;

    @Override
    public List<StaffEntity> findAll() {
        return this.repository.findAll();
    }

    @Override
    public StaffEntity save(StaffEntity staffEntity) {
        return this.repository.save(staffEntity);
    }

    @Override
    public List<StaffEntity> findByFirstNameIgnoreCase(String nome) {
        //return this.repository.findByFirstNameIgnoreCase(nome);
        //return this.repository.buscarPeloPrimeirNomeSql(nome);
        //return this.repository.buscarPeloPrimeirNomeJpql(nome);
        return this.repository.listarPorPrimeiroNome(nome);
    }


}
