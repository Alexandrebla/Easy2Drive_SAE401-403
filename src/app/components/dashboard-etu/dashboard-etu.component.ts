import { Component } from '@angular/core';
import { NavbarEtuComponent } from '../navbar-etu/navbar-etu.component';

@Component({
  selector: 'app-dashboard',
  imports: [NavbarEtuComponent],
  templateUrl: './dashboard-etu.component.html',
  styleUrl: './dashboard-etu.component.css'
})
export class DashboardComponent {
  constructor() { }

  ngOnInit(): void {
    // Appeler la fonction qui modifie l'animation une fois que la vue est chargée
    this.resetAnimation();
  }

  private resetAnimation(): void {
    const bug = document.querySelector('.bug') as HTMLElement;

    if (bug) {
      // Réinitialiser l'animation en supprimant puis réajoutant la classe 'animation'
      bug.style.animation = 'none'; // Retirer l'animation
      bug.offsetHeight; // Forcer le reflow pour réinitialiser l'animation
      bug.style.animation = ''; // Remettre l'animation
    }
  }
}
