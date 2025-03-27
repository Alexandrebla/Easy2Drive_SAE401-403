import { Component, OnInit } from '@angular/core';
import { AdminService } from '../../services/admin.service';
import { NavbarAdminComponent } from '../navbar-admin/navbar-admin.component';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-list-etudiant',
  standalone: true,
  imports: [CommonModule, FormsModule, NavbarAdminComponent],
  templateUrl: './list-etudiant.component.html',
  styleUrls: ['./list-etudiant.component.css']
})
export class ListEtudiantComponent implements OnInit {
  students: any[] = [];
  isAddModalOpen = false;
  isEditModalOpen = false;
  selectedStudent: any = null;

  newStudent = {
    prenom: '',
    nom: '',
    neph: '',
    date_inscription: '',
    etg: null,
    echec_etg: null,
    login: '',
    password: ''
  };

  constructor(private adminService: AdminService) {}

  ngOnInit() {
    this.loadStudents();
  }

  loadStudents() {
    this.adminService.getStudents().subscribe({
      next: (response: any) => {
        console.log("Réponse API :", response);
        this.students = response.etudiants;
      },
      error: (error) => {
        console.error('Erreur de chargement des étudiants', error);
      }
    });
  }

  // ✅ Ouvrir le modal d'ajout
  openAddModal() {
    this.isAddModalOpen = true;
  }

  // ✅ Ouvrir le modal de modification avec les données de l'étudiant sélectionné
  openEditModal(student: any) {
    this.selectedStudent = { ...student }; // Copie des données pour ne pas modifier directement l'objet original
    this.isEditModalOpen = true;
  }

  // ✅ Fermer les modaux
  closeModals() {
    this.isAddModalOpen = false;
    this.isEditModalOpen = false;
  }

  // ✅ Ajouter un étudiant
  submitStudent() {
    this.adminService.addStudent(this.newStudent).subscribe({
      next: (response) => {
        console.log('Étudiant ajouté avec succès !', response);
        this.loadStudents();
        this.closeModals();
      },
      error: (error) => {
        console.error('Erreur lors de l’ajout de l’étudiant', error);
      }
    });
  }

  // ✅ Modifier un étudiant
  submitEditStudent() {
    this.adminService.modif_etu(this.selectedStudent).subscribe({
      next: (response) => {
        console.log('Modification réussie', response);
        this.loadStudents();
        this.closeModals();
      },
      error: (error) => {
        console.error('Erreur lors de la modification', error);
      }
    });
  }

  // ✅ Supprimer un étudiant
  deleteStudent(id: number) {
    if (confirm("Voulez-vous vraiment supprimer cet étudiant ?")) {
      this.adminService.deleteEtu(id).subscribe({
        next: (response: any) => {
          console.log("Suppression réussie :", response);
          this.loadStudents();
        },
        error: (error) => {
          console.error("Erreur lors de la suppression de l'étudiant", error);
        }
      });
    }
  }
}
