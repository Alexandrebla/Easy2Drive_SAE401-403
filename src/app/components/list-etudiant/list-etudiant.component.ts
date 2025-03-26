import { Component, OnInit } from '@angular/core';
import { AdminService } from '../../services/admin.service';
import { NavbarAdminComponent } from '../navbar-admin/navbar-admin.component';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-list-etudiant',
  imports: [NavbarAdminComponent, CommonModule, FormsModule],
  templateUrl: './list-etudiant.component.html',
  styleUrls: ['./list-etudiant.component.css']
})
export class ListEtudiantComponent implements OnInit {
  students: any[] = [];

  constructor(private adminService: AdminService) {}

  ngOnInit() {
    this.loadStudents();
  }

  loadStudents() {
    this.adminService.getStudents().subscribe({
      next: (response: any) => {
        console.log("Réponse API :", response); // DEBUG
        this.students = response.etudiants;
      },
      error: (error) => {
        console.error('Erreur de chargement des étudiants', error);
      }
    });
  }
  
}
