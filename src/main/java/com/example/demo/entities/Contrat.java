package com.example.demo.entities;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "contrat")
public class Contrat {
	    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long id;
	    private String reference;
	    private LocalDate dateDebut;
	    private String typeContrat;
	    private Double salaire;

	    @OneToOne(mappedBy = "contrat")
	    private Employe employe;
	}
