package br.com.jovemdev.dvdrental.repository.impl;

import br.com.jovemdev.dvdrental.entity.QStaffEntity;
import br.com.jovemdev.dvdrental.entity.StaffEntity;
import br.com.jovemdev.dvdrental.repository.StaffEntityRepositoryCustom;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.jpa.impl.JPAQuery;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

public class StaffEntityRepositoryImpl implements StaffEntityRepositoryCustom {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<StaffEntity> listarPorPrimeiroNome(String nome) {
        final QStaffEntity staff = QStaffEntity.staffEntity;

        BooleanBuilder where = new BooleanBuilder();
        where.and(staff.firstName.containsIgnoreCase(nome));

        return new JPAQuery<StaffEntity>(em)
                .select(staff)
                .from(staff)
                .where(where)
                .fetch();
    }
}
