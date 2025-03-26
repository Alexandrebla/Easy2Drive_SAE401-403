import { Component, OnInit } from '@angular/core';
import { AdminService } from '../../services/admin.service';
import { NavbarAdminComponent } from '../navbar-admin/navbar-admin.component';

@Component({
  selector: 'app-avis-admin',
  imports: [NavbarAdminComponent],
  templateUrl: './avis-admin.component.html',
  styleUrl: './avis-admin.component.css'
})
export class AvisAdminComponent implements OnInit {
  reviews: any[] = [];

  constructor(private adminService: AdminService) { }

  ngOnInit() {
    this.loadReviews();
  }

  loadReviews() {
    this.adminService.getReviews().subscribe({
      next: (response: any) => {
        this.reviews = response.reviews;
      },
      error: (error) => {
        console.error('Erreur de chargement des avis', error);
      }
    });
  }

  moderateReview(id: number, status: string) {
    this.adminService.moderateReview(id, status).subscribe({
      next: () => {
        this.loadReviews(); // Recharge la liste après modération
      },
      error: (error) => {
        console.error('Erreur de modération', error);
      }
    });
  }
}
