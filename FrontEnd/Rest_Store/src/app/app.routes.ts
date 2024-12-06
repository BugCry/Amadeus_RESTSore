import { Routes } from '@angular/router';
import { ProductComponent } from './components/product/product.component';
import { AppComponent } from './app.component';
import { ProductTypeComponent } from './components/productType/productType.component';
import { UserComponent } from './components/user/user.component';
import { UserTypeComponent } from './components/userType/userType.component';
import { InventoryComponent } from './components/inventory/inventory.component';

export const routes: Routes = [
    {
        path: 'products',
        component: ProductComponent
    },
    {
        path: 'products/types',
        component: ProductTypeComponent
    },
    {
        path: 'inventory',
        component: InventoryComponent
    },
    {
        path: 'invoice',
        component: ProductComponent
    },
    {
        path: 'users',
        component: UserComponent
    },
    {
        path: 'users/types',
        component: UserTypeComponent
    },
    {
        path: 'home',
        component: AppComponent
    },
    {
        path: '**',
        redirectTo: '/home'
    },
];
