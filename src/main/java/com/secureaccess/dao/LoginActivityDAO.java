package com.secureaccess.dao;

import com.secureaccess.model.LoginActivity;
import java.util.*;

public class LoginActivityDAO {
    public int getTotalLogins() { return 0; }
    public int getFailedLogins() { return 0; }
    public int getSuspiciousCount() { return 0; }
    public List<LoginActivity> getAllActivities() { return new ArrayList<>(); }
}
