import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

import { CommonModule } from '@angular/common';
import { HttpClientModule,HttpClient } from '@angular/common/http';
import { FormControl,FormGroup,Validators,FormsModule,ReactiveFormsModule } from '@angular/forms';

import { DataTablesModule } from 'angular-datatables';
import { Config } from 'datatables.net';
import { Subject } from 'rxjs';
import { UserService } from '../../service/user.service';
import { UsersType } from '../../model/usersType.model';

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
  templateUrl: './userType.component.html',
  styleUrl: './userType.component.css'
})
export class UserTypeComponent {
  showCancel:boolean = false;
  idEditing:number = 0;
  usersList!:UsersType[];
  tasks:any=[];
  newtask="";
  APIURL="https://localhost:44313/api/";
  dtOptions: Config = {};
  dtTrigger:Subject<any>=new Subject<any>();
  public userForm!: FormGroup;

  constructor(private service:UserService,private http:HttpClient){}

  ngOnInit(){
    this.get_UsersType();

    this.dtOptions = {
      pagingType: 'full',
    };
    this.dtTrigger.next(null);  

    this.userForm = new FormGroup({
      name: new FormControl("", Validators.required),
      description: new FormControl("", Validators.required),
      customer: new FormControl("", Validators.required),
      admin: new FormControl("", Validators.required),
    });
  }

  userTypeFormAction(){
    if(this.showCancel){
      this.mod_UserType();
    }else{
      this.add_UserType();
    }
  }

  editUserType(item:UsersType){
    this.showCancel = true;
    this.idEditing = item.id;

    this.userForm.controls['name'].setValue(item.name);
    this.userForm.controls['description'].setValue(item.description);
    this.userForm.controls['customer'].setValue(item.customer);
    this.userForm.controls['admin'].setValue(item.admin);
  }

  get_UsersType(){
    this.service.get_UsersType().subscribe((res)=>{
      this.tasks=res;
      this.dtTrigger.next(null);
    })
  }

  add_UserType(){
    const body = {
      "name":this.userForm.controls['name'].value,
      "description":this.userForm.controls['description'].value,
      "customer":this.userForm.controls['customer'].value,
      "admin":this.userForm.controls['admin'].value,
      "status":"true",
    }
    this.service.add_UserType(body).subscribe((res)=>{
      alert(res)
      this.userForm.reset();
      window.location.reload();
      // this.get_Users();
    })
  }

  mod_UserType(){
    const body = {
      "name":this.userForm.controls['name'].value,
      "description":this.userForm.controls['description'].value,
      "customer":this.userForm.controls['customer'].value,
      "admin":this.userForm.controls['admin'].value,
      "status":"true",
    }
    this.service.mod_UserType(body,this.idEditing).subscribe((res)=>{
      alert(res)
      this.userForm.reset();
      window.location.reload();
      // this.get_Users();
    })
  }

  deleteUserType(item:UsersType){
    const body = {
      "status":!item.status,
    }
    this.service.del_UserType(body,item.id).subscribe((res)=>{
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
