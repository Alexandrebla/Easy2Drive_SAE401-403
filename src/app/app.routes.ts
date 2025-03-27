import { Routes } from '@angular/router';
import { DashboardComponent } from './components/dashboard-etu/dashboard-etu.component';
import { ProfilComponent } from './components/profil/profil.component';
import { ProfilAdminComponent } from './components/profil-admin/profil-admin.component';
import { DashboardAdminComponent } from './components/dashboard-admin/dashboard-admin.component';
import { AccueilComponent } from './components/accueil/accueil.component';
import { AvisAdminComponent } from './components/avis-admin/avis-admin.component';
import { AvisEtuComponent } from './components/avis-etu/avis-etu.component';
import { ConnexionComponent } from './components/connexion/connexion.component';
import { InscriptionComponent } from './components/inscription/inscription.component';
import { ListEtudiantComponent } from './components/list-etudiant/list-etudiant.component';
import { ListTestComponent } from './components/list-test/list-test.component';
import { ResultatComponent } from './components/resultat/resultat.component';

export const routes: Routes = [
    { path: 'dash_etu', component: DashboardComponent },
    { path: 'profil', component: ProfilComponent },
    { path: 'dash_admin', component:  DashboardAdminComponent},
    { path: 'aa', component: AccueilComponent },
    { path: 'avis_admin', component: AvisAdminComponent },
    { path: 'avis_etu', component: AvisEtuComponent },
    { path: '', component: ConnexionComponent },
    { path: 'incripstion', component: InscriptionComponent },
    { path: 'list_etu', component: ListEtudiantComponent },
    { path: 'list_test', component: ListTestComponent },
    { path: 'resultat', component: ResultatComponent },
    { path: 'profil_admin', component: ProfilAdminComponent}
];
