import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Users } from "../model/users.model";
import { UsersType } from "../model/usersType.model";

@Injectable({
    providedIn: 'root'
})

export class UserService {
    
    APIURL="https://localhost:44313/api/";

    constructor(private http:HttpClient) { }

    // Users

    get_Users(){
        return this.http.get<Users[]>(this.APIURL+"User")
    }

    add_User(body:any){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.post(this.APIURL+"User",body,{headers});
    }
    
    mod_User(body:any,id:number){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.put(this.APIURL+"User/"+id,body,{headers});
    }

    del_User(body:any,id:number){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.post(this.APIURL+"User/delete/"+id,body,{headers});
    }

    // Users Types

    get_UsersType(){
        return this.http.get<UsersType[]>(this.APIURL+"UserType")
    }

    add_UserType(body:any){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.post(this.APIURL+"UserType",body,{headers});
    }
    
    mod_UserType(body:any,id:number){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.put(this.APIURL+"UserType/"+id,body,{headers});
    }

    del_UserType(body:any,id:number){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.post(this.APIURL+"UserType/delete/"+id,body,{headers});
    }
}