import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { AdminService } from '../../services/admin.service';
import { NavbarAdminComponent } from '../navbar-admin/navbar-admin.component';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-profile-admin',
  standalone: true,
  imports: [NavbarAdminComponent, FormsModule, CommonModule],
  templateUrl: './profil-admin.component.html',
  styleUrls: ['./profil-admin.component.css'] // ✅ Correction ici
})
export class ProfilAdminComponent implements OnInit {
  profile: any = {}; // ✅ Evite "undefined" en initialisant un objet vide

  constructor(private adminService: AdminService, private route: ActivatedRoute) {}

  ngOnInit(): void {
    const userId = this.route.snapshot.paramMap.get('id');
    if (userId) {
      this.loadProfile(userId);
    }
  }

  loadProfile(userId: string): void {
    this.adminService.getProfile(userId).subscribe({
      next: (response: any) => {
        if (response.success && response.profil) { // ✅ Vérifie si les données existent
          this.profile = response.profil;
          console.log("Profil chargé :", this.profile); // ✅ Vérification console
        } else {
          console.warn('⛔ Profil non trouvé ou erreur API');
        }
      },
      error: (error: any) => {
        console.error('❌ Erreur de chargement du profil', error);
      }
    });
  }
}
