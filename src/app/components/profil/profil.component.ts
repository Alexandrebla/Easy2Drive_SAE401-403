import { Component, OnInit } from '@angular/core';
import { StudentService } from '../../services/student.service';
import { NavbarEtuComponent } from '../navbar-etu/navbar-etu.component';

@Component({
  selector: 'app-profil',
  imports: [NavbarEtuComponent],
  templateUrl: './profil.component.html',
  styleUrl: './profil.component.css'
})
export class ProfilComponent implements OnInit {
  profile: any = {};

  constructor(private studentService: StudentService) { }

  ngOnInit() {
    this.loadProfile();
  }

  loadProfile() {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    this.studentService.getProfile(user.id).subscribe({
      next: (response: any) => {
        this.profile = response;
      },
      error: (error) => {
        console.error('Erreur de chargement du profil', error);
      }
    });
  }
}
