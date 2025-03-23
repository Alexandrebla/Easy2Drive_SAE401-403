import { Component } from '@angular/core';
import Chart from 'chart.js/auto';

@Component({
  selector: 'app-dashboard',
  imports: [],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
  public chart: any;
  
    createChart(){
      this.chart = new Chart("MyChart", {
        type: 'line', // Changement du type de graphique en 'line'
        data: {
          labels: ['test1', 'test1', 'test1', 'test1', 'test1', 'test1'], // Labels sur l'axe X
          datasets: [{
            label: 'My First Dataset',
            data: [5, 11, 17, 8, 14, 20],
            borderColor: 'blue', // Couleur de la ligne
            backgroundColor: 'rgba(0, 0, 255, 0.2)', // Couleur de remplissage légère
            fill: true, // Remplissage sous la ligne
            tension: 0.4 // Lissage de la courbe
          }]
        },
        options: {
          aspectRatio: 2.5,
          scales: {
            x: {
              beginAtZero: true
            },
            y: {
              beginAtZero: true
            }
          }
        }
      });
  }
    ngOnInit(): void {
      this.createChart();
    }

}
