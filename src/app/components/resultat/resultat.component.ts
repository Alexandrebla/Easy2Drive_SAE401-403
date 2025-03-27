import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { StudentService } from '../../services/student.service';
import { NavbarEtuComponent } from '../navbar-etu/navbar-etu.component';

@Component({
  selector: 'app-resultat',
  templateUrl: './resultat.component.html',
  styleUrls: ['./resultat.component.css'],
  standalone: true,
  imports: [CommonModule, NavbarEtuComponent]
})
export class ResultatComponent implements OnInit {
  examens: any[] = [];

  constructor(private studentService: StudentService) {}

  ngOnInit(): void {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    if (!user?.id) return;

    this.studentService.getExamens(user.id).subscribe({
      next: (res: any) => {
        if (res.success) {
          this.examens = res.examens;
        } else {
          console.error("Erreur lors du chargement des examens");
        }
      },
      error: (err) => console.error("Erreur API:", err)
    });
  }

  afficherDetails(examen : any): void {
    console.log('Détails de l\'examen', examen);
  }
}
