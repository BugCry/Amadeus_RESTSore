import { bootstrapApplication } from '@angular/platform-browser';

import { AppComponent } from './app/app.component';
import { ProductComponent } from './app/components/product/product.component'; 

import { appConfig } from './app/app.config';

bootstrapApplication(AppComponent, appConfig)
  .catch((err) => console.error(err));
