package com.example.demo.entities;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "mission_externe")
public class MissionExterne extends Mission {
    private String emailFacturation;
    private Double tauxJournalierMoyen;
}
