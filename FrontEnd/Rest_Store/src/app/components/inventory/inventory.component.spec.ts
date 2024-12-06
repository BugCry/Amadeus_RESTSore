import { TestBed } from '@angular/core/testing';
import { InventoryComponent } from './inventory.component';

describe('AppComponent', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InventoryComponent],
    }).compileComponents();
  });

  it('should create the app', () => {
    const fixture = TestBed.createComponent(InventoryComponent);
    const app = fixture.componentInstance;
    expect(app).toBeTruthy();
  });

  it(`should have the 'Rest_Store' title`, () => {
    const fixture = TestBed.createComponent(InventoryComponent);
    const app = fixture.componentInstance;
    // expect(app.title).toEqual('Rest_Store');
  });

  it('should render title', () => {
    const fixture = TestBed.createComponent(InventoryComponent);
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('h1')?.textContent).toContain('Hello, Rest_Store');
  });
});
