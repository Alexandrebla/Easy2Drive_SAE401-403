import { Component, OnInit } from '@angular/core';
import { AdminService } from '../../services/admin.service';
import { NavbarAdminComponent } from '../navbar-admin/navbar-admin.component';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-avis-admin',
  imports: [NavbarAdminComponent, FormsModule, CommonModule],
  templateUrl: './avis-admin.component.html',
  styleUrl: './avis-admin.component.css'
})
export class AvisAdminComponent implements OnInit {
  students: any[] = [];
  avis: any[] = [];
  showPopup: boolean = false;  // ✅ Gère l'affichage du popup
  selectedAvis: any = {};      // ✅ Stocke l'avis sélectionné

  constructor(private adminService: AdminService) {}

  warningMessage: string = "";
  sendWarning() {
    this.warningMessage = "⚠️ Avertissement : Action requise !";
  }
  

  ngOnInit(): void {
    this.viewAvis();
  }

  // ✅ Charger les avis depuis l'API
  viewAvis() {
    this.adminService.getAvis().subscribe({
      next: (response: any) => {
        console.log("Réponse API :", response);
        this.avis = response.avis;
      },
      error: (error) => {
        console.error('Erreur de chargement des avis', error);
      }
    });
  }

  // ✅ Convertir une note en étoiles (tableau pour *ngFor)
  getStars(note: number): any[] {
    return new Array(note);
  }

  // ✅ Ouvrir le popup pour modifier un avis
  openPopup(avis: any) {
    this.selectedAvis = { ...avis }; // Clone pour éviter de modifier l'original
    this.showPopup = true;
  }

  // ✅ Fermer le popup
  closePopup() {
    this.showPopup = false;
  }

  deleteAvis(id: number) {
    if (confirm("Voulez-vous vraiment supprimer cet avis ?")) {
      this.adminService.deleteAvis(id).subscribe({
        next: (response: any) => {
          console.log("Avis supprimé :", response);
          this.viewAvis(); // Recharger la liste après suppression
        },
        error: (error) => {
          console.error("Erreur lors de la suppression de l'avis", error);
        }
      });
    }
  }
  
}
