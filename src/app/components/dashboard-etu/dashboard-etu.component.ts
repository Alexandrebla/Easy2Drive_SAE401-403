import { Component, OnInit } from '@angular/core';
import { StudentService } from '../../services/student.service';
import { NavbarEtuComponent } from '../navbar-etu/navbar-etu.component';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [NavbarEtuComponent],
  templateUrl: './dashboard-etu.component.html',
  styleUrl: './dashboard-etu.component.css'
})
export class DashboardComponent implements OnInit {
  profile: any;
  prenom: string = '';
  reviews: any[] = [];

  constructor(private studentService: StudentService) {}

  ngOnInit(): void {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    if (user.id) {
      this.loadProfile(user.id);
    }
  }

  loadProfile(userId: number) {
    this.studentService.getProfile(userId.toString()).subscribe({
      next: (response: any) => {
        if (response.success) {
          this.profile = response.profil;
          this.prenom = this.profile.prenom;
        } else {
          console.warn('⛔ Profil non trouvé ou erreur API');
        }
      },
      error: (error: any) => {
        console.error('❌ Erreur de chargement du profil', error);
      }
    });
  }

  loadReviews(userId: number) {
    this.studentService.getReviews(userId.toString()).subscribe({
      next: (response: any) => {
        if (response.success) {
          this.reviews = response.reviews;
        } else {
          console.warn('⛔ Avis non trouvés ou erreur API');
        }
      },
      error: (error) => {
        console.error('❌ Erreur de chargement des avis', error);
      }
    });
  }
}
