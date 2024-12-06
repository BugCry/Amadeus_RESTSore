import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

import { CommonModule } from '@angular/common';
import { HttpClientModule,HttpClient } from '@angular/common/http';
import { FormsModule,ReactiveFormsModule } from '@angular/forms';

import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { DataTablesModule } from 'angular-datatables';
import { Config } from 'datatables.net';
import { Subject } from 'rxjs';

import { ProductService } from './service/product.service';

import { Products } from './model/products.model';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    RouterOutlet,
    CommonModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
    DataTablesModule,
    FontAwesomeModule
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'Rest_Store';

  productsList!:Products[];
  tasks:any=[];
  newtask="";
  APIURL="https://localhost:44313/api/";
  dtOptions: Config = {};
  dtTrigger:Subject<any>=new Subject<any>();

  constructor(private service:ProductService,private http:HttpClient){}

  ngOnInit(){
    this.get_Products();

    this.dtOptions = {
      pagingType: 'full',
    };
  }

  get_Products(){
    this.service.get_Products().subscribe((res)=>{
      this.tasks=res;
      this.dtTrigger.next(null);
    })
  }

  add_Product(){
    let body = new FormData();
    body.append('task',this.newtask);
    this.http.post(this.APIURL+"Product",body).subscribe((res)=>{
      alert(res)
      this.newtask="";
      this.get_Products();
    })
  }
}
