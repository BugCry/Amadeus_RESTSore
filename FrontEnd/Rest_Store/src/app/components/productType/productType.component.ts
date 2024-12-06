import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

import { CommonModule } from '@angular/common';
import { HttpClientModule,HttpClient } from '@angular/common/http';
import { FormControl,FormGroup,Validators,FormsModule,ReactiveFormsModule } from '@angular/forms';

import { DataTablesModule } from 'angular-datatables';
import { Config } from 'datatables.net';
import { Subject } from 'rxjs';
import { ProductService } from '../../service/product.service';
import { ProductsType } from '../../model/productsType.model';

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
  ],
  templateUrl: './productType.component.html',
  styleUrl: './productType.component.css'
})
export class ProductTypeComponent {
  showCancel:boolean = false;
  idEditing:number = 0;
  productsList!:ProductsType[];
  tasks:any=[];
  newtask="";
  APIURL="https://localhost:44313/api/";
  dtOptions: Config = {};
  dtTrigger:Subject<any>=new Subject<any>();
  public productForm!: FormGroup;

  constructor(private service:ProductService,private http:HttpClient){}

  ngOnInit(){
    this.get_ProductsType();

    this.dtOptions = {
      pagingType: 'full',
    };
    this.dtTrigger.next(null);  

    this.productForm = new FormGroup({
      name: new FormControl("", Validators.required),
      description: new FormControl("", Validators.required),
    });
  }

  productTypeFormAction(){
    if(this.showCancel){
      this.mod_ProductType();
    }else{
      this.add_ProductType();
    }
  }

  editProductType(item:ProductsType){
    this.showCancel = true;
    this.idEditing = item.id;

    this.productForm.controls['name'].setValue(item.name);
    this.productForm.controls['description'].setValue(item.description);
  }

  get_ProductsType(){
    this.service.get_ProductsType().subscribe((res)=>{
      this.tasks=res;
      this.dtTrigger.next(null);
    })
  }

  add_ProductType(){
    const body = {
      "name":this.productForm.controls['name'].value,
      "description":this.productForm.controls['description'].value,
      "status":"true",
    }
    this.service.add_ProductType(body).subscribe((res)=>{
      alert(res)
      this.productForm.reset();
      window.location.reload();
      // this.get_Products();
    })
  }

  mod_ProductType(){
    const body = {
      "name":this.productForm.controls['name'].value,
      "description":this.productForm.controls['description'].value,
      "status":"true",
    }
    this.service.mod_ProductType(body,this.idEditing).subscribe((res)=>{
      alert(res)
      this.productForm.reset();
      window.location.reload();
      // this.get_Products();
    })
  }

  deleteProductType(item:ProductsType){
    const body = {
      "status":!item.status,
    }
    this.service.del_ProductType(body,item.id).subscribe((res)=>{
      alert(res)
      this.productForm.reset();
      window.location.reload();
      // this.get_Products();
    })
  }

  cancelEdit(){
    this.showCancel = !this.showCancel; 
    this.idEditing = 0;

    this.productForm.reset();
  }

}
