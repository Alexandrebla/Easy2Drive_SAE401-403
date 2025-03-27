import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

interface LoginResponse {
  success: boolean;
  user?: {
    id: number;
    login: string;
    role: string;
  };
  message?: string;
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private apiUrl = 'http://localhost/api/auth';

  constructor(private http: HttpClient) { }

  login(login: string, password: string): Observable<LoginResponse> {
    const data = { login, password };
    
    return this.http.post<LoginResponse>(`${this.apiUrl}/login.php`, data);
  }

  isLoggedIn(): boolean {
    return localStorage.getItem('user') !== null;
  }

  isAdmin(): boolean {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    return user.role === 'admin';
  }

  // Pour tester, utilise :
  // login: admin.test
  // password: adminpass123
}
