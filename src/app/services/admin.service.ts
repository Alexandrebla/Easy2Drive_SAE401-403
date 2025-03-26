import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AdminService {
  private apiUrl = 'http://localhost/api/admin';

  constructor(private http: HttpClient) { }

  // Récupérer la liste des étudiants
  getStudents() {
    return this.http.get(`https://marwantom.alwaysdata.net/admin/list_etudiant.php`);
  }

  // Ajouter un étudiant
  addStudent(student: any) {
    return this.http.post(`${this.apiUrl}/students.php`, student);
  }

  // Supprimer un étudiant
  deleteStudent(id: number) {
    return this.http.delete(`${this.apiUrl}/students.php?id=${id}`);
  }

  // Gérer les avis
  getReviews() {
    return this.http.get(`${this.apiUrl}/reviews.php`);
  }

  // Modérer un avis
  moderateReview(id: number, status: string) {
    return this.http.put(`${this.apiUrl}/reviews.php`, { id_avis: id, statut: status });
  }

  getProfile(userId: string): Observable<any> {
      return this.http.get(`https://marwantom.alwaysdata.net/admin/profile_admin.php?id=${userId}`);
    }
}



