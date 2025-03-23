import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AvisEtuComponent } from './avis-etu.component';

describe('AvisEtuComponent', () => {
  let component: AvisEtuComponent;
  let fixture: ComponentFixture<AvisEtuComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AvisEtuComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AvisEtuComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
