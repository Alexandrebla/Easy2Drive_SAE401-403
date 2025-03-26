import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DashboardEtuComponent } from './dashboard-etu.component';

describe('DashboardEtuComponent', () => {
  let component: DashboardEtuComponent;
  let fixture: ComponentFixture<DashboardEtuComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DashboardEtuComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DashboardEtuComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
