package com.example.demo.entities;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.JoinColumn;

@Entity
@Table(name = "timesheet")
public class Timesheet {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private LocalDate dateDebut;
    private LocalDate dateFin;
    private Boolean isValide;

    @ManyToMany
    @JoinTable(name = "timesheet_employe",
        joinColumns = @JoinColumn(name = "timesheet_id"),
        inverseJoinColumns = @JoinColumn(name = "employe_id"))
    private List<Employe> employes;

    @ManyToMany
    @JoinTable(name = "timesheet_mission",
        joinColumns = @JoinColumn(name = "timesheet_id"),
        inverseJoinColumns = @JoinColumn(name = "mission_id"))
    private java.util.List<Mission> missions;
}
