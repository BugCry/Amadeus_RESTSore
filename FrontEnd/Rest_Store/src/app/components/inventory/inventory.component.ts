import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

import { CommonModule } from '@angular/common';
import { HttpClientModule,HttpClient } from '@angular/common/http';
import { FormControl,FormGroup,Validators,FormsModule,ReactiveFormsModule } from '@angular/forms';

import { DataTablesModule } from 'angular-datatables';
import { Config } from 'datatables.net';
import { Subject } from 'rxjs';
import { InventoryService } from '../../service/inventory.service';
import { Inventories } from '../../model/inventories.model';
import { UserService } from '../../service/user.service';
import { ProductService } from '../../service/product.service';

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
  templateUrl: './inventory.component.html',
  styleUrl: './inventory.component.css'
})
export class InventoryComponent {
  showCancel:boolean = false;
  idEditing:number = 0;
  inventorysList!:Inventories[];
  prodList:any=[];
  usersList:any=[];
  productsList:any=[];
  newtask="";
  APIURL="https://localhost:44313/api/";
  dtOptions: Config = {};
  dtTrigger:Subject<any>=new Subject<any>();
  public inventoryForm!: FormGroup;

  constructor(private service:InventoryService,private http:HttpClient, private serviceUser:UserService, private serviceProd:ProductService){}

  ngOnInit(){
    this.get_Inventories();
    this.get_Users();
    this.get_Products();

    this.dtOptions = {
      pagingType: 'full',
    };
    this.dtTrigger.next(null);  

    this.inventoryForm = new FormGroup({
      product: new FormControl("", Validators.required),
      quantity: new FormControl("", Validators.required),
      user: new FormControl("", Validators.required),
    });
  }

  inventoryFormAction(){
    if(this.showCancel){
      this.mod_Inventory();
    }else{
      this.add_Inventory();
    }
  }

  editInventory(item:Inventories){
    this.showCancel = true;
    this.idEditing = item.id;

    this.inventoryForm.controls['product'].setValue(item.productId);
    this.inventoryForm.controls['quantity'].setValue(item.quantity);
    this.inventoryForm.controls['user'].setValue(item.userId);
  }

  get_Inventories(){
    this.service.get_Inventory().subscribe((res)=>{
      this.inventorysList=res;
      this.dtTrigger.next(null);
    })
  }

  get_Products(){
    this.serviceProd.get_Products().subscribe((res)=>{
      this.prodList=res;
    })
  }

  get_Users(){
    this.serviceUser.get_Users().subscribe((res)=>{
      this.usersList=res;
    })
  }

  add_Inventory(){
    const body = {
      "product":this.inventoryForm.controls['product'].value,
      "quantity":this.inventoryForm.controls['quantity'].value,
      "user":this.inventoryForm.controls['user'].value,
      "status":"true",
    }
    console.log(body);
    this.service.add_Inventory(body).subscribe((res)=>{
      alert(res)
      this.inventoryForm.reset();
      window.location.reload();
      // this.get_Inventories();
    })
  }

  mod_Inventory(){
    const body = {
      "product":this.inventoryForm.controls['product'].value,
      "quantity":this.inventoryForm.controls['quantity'].value,
      "user":this.inventoryForm.controls['user'].value,
      "modificationDate":Date.now,
      "status":"true",
    }
    this.service.mod_Inventory(body,this.idEditing).subscribe((res)=>{
      alert(res)
      this.inventoryForm.reset();
      window.location.reload();
      // this.get_Inventories();
    })
  }

  deleteInventory(item:Inventories){
    const body = {
      "status":!item.status,
    }
    this.service.del_Inventory(body,item.id).subscribe((res)=>{
      alert(res)
      this.inventoryForm.reset();
      window.location.reload();
      // this.get_Inventories();
    })
  }

  cancelEdit(){
    this.showCancel = !this.showCancel; 
    this.idEditing = 0;

    this.inventoryForm.reset();
  }

}
