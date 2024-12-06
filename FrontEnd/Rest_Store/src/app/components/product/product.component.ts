import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

import { CommonModule } from '@angular/common';
import { HttpClientModule,HttpClient } from '@angular/common/http';
import { FormControl,FormGroup,Validators,FormsModule,ReactiveFormsModule } from '@angular/forms';

import { DataTablesModule } from 'angular-datatables';
import { Config } from 'datatables.net';
import { Subject } from 'rxjs';
import { ProductService } from '../../service/product.service';
import { Products } from '../../model/products.model';

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
  templateUrl: './product.component.html',
  styleUrl: './product.component.css'
})
export class ProductComponent {
  showCancel:boolean = false;
  idEditing:number = 0;
  productsList!:Products[];
  prodList:any=[];
  typesList:any=[];
  newtask="";
  APIURL="https://localhost:44313/api/";
  dtOptions: Config = {};
  dtTrigger:Subject<any>=new Subject<any>();
  public productForm!: FormGroup;

  constructor(private service:ProductService,private http:HttpClient){}

  ngOnInit(){
    this.get_Products();
    this.get_ProductsType();

    this.dtOptions = {
      pagingType: 'full',
    };
    this.dtTrigger.next(null);  

    this.productForm = new FormGroup({
      name: new FormControl("", Validators.required),
      type: new FormControl("", Validators.required),
      price: new FormControl("", Validators.required),
      condition: new FormControl("", Validators.required),
      description: new FormControl(null),
      brand: new FormControl("", Validators.required),
    });
  }

  productFormAction(){
    if(this.showCancel){
      this.mod_Product();
    }else{
      this.add_Product();
    }
  }

  editProduct(item:Products){
    this.showCancel = true;
    this.idEditing = item.id;

    this.productForm.controls['name'].setValue(item.name);
    this.productForm.controls['type'].setValue(item.typeId);
    this.productForm.controls['price'].setValue(item.price);
    this.productForm.controls['condition'].setValue(item.condition);
    this.productForm.controls['description'].setValue(item.description);
    this.productForm.controls['brand'].setValue(item.brand);
  }

  get_ProductsType(){
    this.service.get_ProductsType().subscribe((res)=>{
      this.typesList=res;
    })
  }

  get_Products(){
    this.service.get_Products().subscribe((res)=>{
      this.prodList=res;
      this.dtTrigger.next(null);
    })
  }

  add_Product(){
    const body = {
      "name":this.productForm.controls['name'].value,
      "typeId":this.productForm.controls['type'].value,
      "price":this.productForm.controls['price'].value,
      "condition":this.productForm.controls['condition'].value,
      "description":this.productForm.controls['description'].value,
      "brand":this.productForm.controls['brand'].value,
      "status":"true",
    }
    this.service.add_Product(body).subscribe((res)=>{
      alert(res)
      this.productForm.reset();
      window.location.reload();
      // this.get_Products();
    })
  }

  mod_Product(){
    const body = {
      "name":this.productForm.controls['name'].value,
      "typeId":this.productForm.controls['type'].value,
      "price":this.productForm.controls['price'].value,
      "condition":this.productForm.controls['condition'].value,
      "description":this.productForm.controls['description'].value,
      "brand":this.productForm.controls['brand'].value,
      "status":"true",
    }
    this.service.mod_Product(body,this.idEditing).subscribe((res)=>{
      alert(res)
      this.productForm.reset();
      window.location.reload();
      // this.get_Products();
    })
  }

  deleteProduct(item:Products){
    const body = {
      "status":!item.status,
    }
    this.service.del_Product(body,item.id).subscribe((res)=>{
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
