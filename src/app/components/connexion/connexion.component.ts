import { Component } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-connexion',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './connexion.component.html',
  styleUrls: ['./connexion.component.css']
})
export class ConnexionComponent {
  login: string = '';
  password: string = '';
  isSubmitting: boolean = false;

  constructor(private http: HttpClient, private router: Router) {}

  onSubmit() {
    if (this.isSubmitting) return;
    this.isSubmitting = true;
  
    console.log('Tentative de connexion avec :', {
      login: this.login,
      password: this.password
    });
  
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
  
    this.http.post<any>('https://marwantom.alwaysdata.net/auth/login.php', {
      login: this.login,
      password: this.password
    }, { headers }).subscribe({
      next: (response) => {
        console.log('Réponse API :', response);
        if (response.success) {
          localStorage.setItem('user', JSON.stringify(response.user));
          this.router.navigate([response.user.role === 'admin' ? '/dash_admin' : '/dash_etu']);
        } else {
          alert(response.message || 'Erreur de connexion');
        }
      },
      error: (error) => {
        console.error('Erreur API :', error);
        alert(error.error?.message || 'Erreur inconnue');
        this.isSubmitting = false;
      },
      complete: () => {
        this.isSubmitting = false;
      }
    });
  }
}