import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class StudentService {

  constructor(private http: HttpClient) {}

  getExamens(id: number) {
    return this.http.get<any>(`https://marwantom.alwaysdata.net/student/get-examens.php?id=${id}`);
  }

  getReviews(userId: string): Observable<any> {
    return this.http.get(`/api/reviews/${userId}`);
  }

  addReview(review: any): Observable<any> {
    return this.http.post('/api/reviews', review);
  }

  getProfile(userId: string): Observable<any> {
    return this.http.get(`https://marwantom.alwaysdata.net/student/profile.php?id=${userId}`);
  }

}
