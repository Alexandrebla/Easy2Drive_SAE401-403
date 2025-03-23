import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NavbarEtuComponent } from './navbar-etu.component';

describe('NavbarEtuComponent', () => {
  let component: NavbarEtuComponent;
  let fixture: ComponentFixture<NavbarEtuComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [NavbarEtuComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(NavbarEtuComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
