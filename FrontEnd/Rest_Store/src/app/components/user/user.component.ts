import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

import { CommonModule } from '@angular/common';
import { HttpClientModule,HttpClient } from '@angular/common/http';
import { FormControl,FormGroup,Validators,FormsModule,ReactiveFormsModule } from '@angular/forms';

import { DataTablesModule } from 'angular-datatables';
import { Config } from 'datatables.net';
import { Subject } from 'rxjs';
import { UserService } from '../../service/user.service';
import { Users } from '../../model/users.model';

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
  templateUrl: './user.component.html',
  styleUrl: './user.component.css'
})
export class UserComponent {
  showCancel:boolean = false;
  idEditing:number = 0;
  usersList!:Users[];
  prodList:any=[];
  typesList:any=[];
  newtask="";
  APIURL="https://localhost:44313/api/";
  dtOptions: Config = {};
  dtTrigger:Subject<any>=new Subject<any>();
  public userForm!: FormGroup;

  constructor(private service:UserService,private http:HttpClient){}

  ngOnInit(){
    this.get_Users();
    this.get_UsersType();

    this.dtOptions = {
      pagingType: 'full',
    };
    this.dtTrigger.next(null);  

    this.userForm = new FormGroup({
      name: new FormControl("", Validators.required),
      type: new FormControl("", Validators.required),
      userName: new FormControl("", Validators.required),
      password: new FormControl("", Validators.required),
      birthDate: new FormControl("", Validators.required),
      address: new FormControl(null),
      city: new FormControl(null),
      zipCode: new FormControl(null),
      email: new FormControl("", Validators.required),
      phone: new FormControl("", Validators.required),
    });
  }

  userFormAction(){
    if(this.showCancel){
      this.mod_User();
    }else{
      this.add_User();
    }
  }

  editUser(item:Users){
    this.showCancel = true;
    this.idEditing = item.id;

    this.userForm.controls['name'].setValue(item.name);
    this.userForm.controls['type'].setValue(item.typeId);
    this.userForm.controls['userName'].setValue(item.userName);
    this.userForm.controls['password'].setValue(item.password);
    this.userForm.controls['birthDate'].setValue(item.birthDate);
    this.userForm.controls['address'].setValue(item.address);
    this.userForm.controls['city'].setValue(item.city);
    this.userForm.controls['zipCode'].setValue(item.zipCode);
    this.userForm.controls['email'].setValue(item.email);
    this.userForm.controls['phone'].setValue(item.phone);
  }

  get_UsersType(){
    this.service.get_UsersType().subscribe((res)=>{
      this.typesList=res;
    })
  }

  get_Users(){
    this.service.get_Users().subscribe((res)=>{
      this.prodList=res;
      this.dtTrigger.next(null);
    })
  }

  add_User(){
    const body = {
      "name":this.userForm.controls['name'].value,
      "typeId":this.userForm.controls['type'].value,
      "userName":this.userForm.controls['userName'].value,
      "password":this.userForm.controls['password'].value,
      "birthDate":this.userForm.controls['birthDate'].value,
      "address":this.userForm.controls['address'].value,
      "city":this.userForm.controls['city'].value,
      "zipCode":this.userForm.controls['zipCode'].value,
      "email":this.userForm.controls['email'].value,
      "phone":this.userForm.controls['phone'].value,
      "status":"true",
    }
    this.service.add_User(body).subscribe((res)=>{
      alert(res)
      this.userForm.reset();
      window.location.reload();
      // this.get_Users();
    })
  }

  mod_User(){
    const body = {
      "name":this.userForm.controls['name'].value,
      "typeId":this.userForm.controls['type'].value,
      "userName":this.userForm.controls['userName'].value,
      "password":this.userForm.controls['password'].value,
      "birthDate":this.userForm.controls['birthDate'].value,
      "address":this.userForm.controls['address'].value,
      "city":this.userForm.controls['city'].value,
      "zipCode":this.userForm.controls['zipCode'].value,
      "email":this.userForm.controls['email'].value,
      "phone":this.userForm.controls['phone'].value,
      "status":"true",
    }
    this.service.mod_User(body,this.idEditing).subscribe((res)=>{
      alert(res)
      this.userForm.reset();
      window.location.reload();
      // this.get_Users();
    })
  }

  deleteUser(item:Users){
    const body = {
      "status":!item.status,
    }
    this.service.del_User(body,item.id).subscribe((res)=>{
      alert(res)
      this.userForm.reset();
      window.location.reload();
      // this.get_Users();
    })
  }

  cancelEdit(){
    this.showCancel = !this.showCancel; 
    this.idEditing = 0;

    this.userForm.reset();
  }

}
