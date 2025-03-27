import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AdminService {
  private apiUrl = 'https://marwantom.alwaysdata.net/admin/';

  constructor(private http: HttpClient) {}

  // ✅ Récupérer la liste des étudiants
  getStudents(): Observable<any> {
    return this.http.get(`${this.apiUrl}list_etudiant.php`);
  }

  // ✅ Ajouter un étudiant
  addStudent(etudiant: any): Observable<any> {
    return this.http.post(`${this.apiUrl}add_etu.php`, etudiant, {
      headers: new HttpHeaders({ 'Content-Type': 'application/json' })
    });
  }

  deleteEtu(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}delete_etu.php`, {
      body: { id },
      headers: { 'Content-Type': 'application/json' }
    });
  }

  modif_etu(etudiant: any): Observable<any> {
    return this.http.put(`${this.apiUrl}modif_etu.php`, etudiant);
  }

  // ✅ Récupérer la liste des avis
  getAvis(): Observable<any> {
    return this.http.get(`${this.apiUrl}afficher_avis.php`);
  }

  // ✅ Supprimer un avis
deleteAvis(id: number): Observable<any> {
  return this.http.delete(`${this.apiUrl}delete_avis.php?id=${id}`);
}

  // ✅ Modérer un avis
  moderateReview(id: number, status: string): Observable<any> {
    return this.http.put(`${this.apiUrl}reviews.php`, 
      { id_avis: id, statut: status }, 
      { headers: new HttpHeaders({ 'Content-Type': 'application/json' }) }
    );
  }

  // ✅ Récupérer le profil d'un administrateur
  getProfile(userId: string): Observable<any> {
    return this.http.get(`${this.apiUrl}profile_admin.php?id=${userId}`);
  }
}
