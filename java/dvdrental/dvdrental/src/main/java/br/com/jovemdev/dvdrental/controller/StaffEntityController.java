package br.com.jovemdev.dvdrental.controller;

import br.com.jovemdev.dvdrental.entity.StaffEntity;
import br.com.jovemdev.dvdrental.service.StaffEntityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/staff")
public class StaffEntityController {

    @Autowired
    private StaffEntityService service;

    @GetMapping("/listar")
    public List<StaffEntity> listar() {
        return service.findAll();
    }

    @GetMapping("/listar-por-nome/{nome}")
    public List<StaffEntity> listarPorNome(@PathVariable String nome) {
        return service.findByFirstNameIgnoreCase(nome);
    }

    @PostMapping("/cadastrar")
    public StaffEntity cadastrar(@RequestBody StaffEntity entity) {
        return service.save(entity);
    }
}
