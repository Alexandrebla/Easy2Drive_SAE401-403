import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { CommonModule } from '@angular/common';
import { ResultatComponent } from './resultat.component';

@NgModule({
  declarations: [
    ResultatComponent
  ],
  imports: [
    BrowserModule,
    CommonModule
  ],
  providers: [],
  bootstrap: [ResultatComponent]
})
export class ResultatModule { }
