import { Routes } from '@angular/router';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { ResultatComponent } from './components/resultat/resultat.component';
import { ProfilComponent } from './components/profil/profil.component';
import { HomeComponent } from './components/home/home.component';
import { AvisComponent } from './components/avis/avis.component';
import { ConnexionComponent } from './components/connexion/connexion.component';
import { InscriptionComponent } from './components/inscription/inscription.component';

export const routes: Routes = [
    { path: '', component: DashboardComponent },
    { path: 'profil', component: ProfilComponent},
    { path: 'home', component: HomeComponent},
    { path: 'resultat', component: ResultatComponent},
    { path: 'avis', component: AvisComponent},
    { path: 'connexion', component: ConnexionComponent},
    { path: 'inscription', component: InscriptionComponent}
];
