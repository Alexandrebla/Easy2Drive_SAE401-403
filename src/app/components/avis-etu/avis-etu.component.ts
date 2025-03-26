import { Component, OnInit } from '@angular/core';
import { StudentService } from '../../services/student.service';
import { NavbarEtuComponent } from '../navbar-etu/navbar-etu.component';

@Component({
  selector: 'app-avis-etu',
  imports: [NavbarEtuComponent],
  templateUrl: './avis-etu.component.html',
  styleUrl: './avis-etu.component.css'
})
export class AvisEtuComponent implements OnInit {
  reviews: any[] = [];
  newReview = {
    contenu: '',
    score: 0
  };

  constructor(private studentService: StudentService) { }

  ngOnInit() {
    this.loadReviews();
  }

  loadReviews() {
    // On récupère l'ID de l'étudiant connecté
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    this.studentService.getReviews(user.id).subscribe({
      next: (response: any) => {
        this.reviews = response.reviews;
      },
      error: (error) => {
        console.error('Erreur de chargement des avis', error);
      }
    });
  }

  submitReview() {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    const review = {
      ...this.newReview,
      id_etudiant: user.id
    };

    this.studentService.addReview(review).subscribe({
      next: () => {
        this.loadReviews();
        this.newReview = { contenu: '', score: 0 }; // Réinitialise le formulaire
      },
      error: (error) => {
        console.error('Erreur d\'ajout d\'avis', error);
      }
    });
  }
}
