import { Component, OnInit } from '@angular/core';
import { AdminService } from '../../services/admin.service';
import { NavbarEtuComponent } from '../navbar-etu/navbar-etu.component';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-avis-admin',
  imports: [NavbarEtuComponent, FormsModule, CommonModule],
  templateUrl: './avis-etu.component.html',
  styleUrl: './avis-etu.component.css'
})
export class AvisEtuComponent implements OnInit {
  students: any[] = [];
  avis: any[] = [];
  selectedAvis: any = {};      // ✅ Stocke l'avis sélectionné

  constructor(private adminService: AdminService) {}

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


  
}
