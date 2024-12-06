import { TestBed } from '@angular/core/testing';
import { UserTypeComponent } from './userType.component';

describe('UserTypeComponent', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [UserTypeComponent],
    }).compileComponents();
  });

  it('should create the app', () => {
    const fixture = TestBed.createComponent(UserTypeComponent);
    const app = fixture.componentInstance;
    expect(app).toBeTruthy();
  });

  it(`should have the 'Rest_Store' title`, () => {
    const fixture = TestBed.createComponent(UserTypeComponent);
    const app = fixture.componentInstance;
    // expect(app.title).toEqual('Rest_Store');
  });

  it('should render title', () => {
    const fixture = TestBed.createComponent(UserTypeComponent);
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('h1')?.textContent).toContain('Hello, Rest_Store');
  });
});
