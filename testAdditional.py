import unittest
import os
import testLib


class AddTests(testLib.RestTestCase):

  def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
    """
    Check that the response data dictionary matches the expected values
    """
    expected = { 'errCode' : errCode }
    if count is not None:
      expected['count']  = count
      self.assertDictEqual(expected, respData)

  # for blank user
  def testAdd1(self):
    respData = self.makeRequest("/users/add", method="POST", data = {'user' : 'wtf', 'password' : '123'})
    self.assertResponse(respData, count = 1, errCode = testLib.RestTestCase.SUCCESS)
  
  # for blank user
  def testAdd2(self):
    respData = self.makeRequest("/users/add", method="POST", data = {'user' : '', 'password' : '123'})
    self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_USERNAME)

  # for user that already exists
  def testAdd3(self):
    self.makeRequest("/users/add", method="POST", data = {'user' : 'wtf', 'password' : '123'})
    respData = self.makeRequest("/users/add", method="POST", data = {'user' : 'wtf', 'password' : '123'})
    self.assertResponse(respData, errCode = testLib.RestTestCase.ERR_USER_EXISTS)
  
  # for user_name too long
  def testAdd4(self):
    respData = self.makeRequest("/users/add", method="POST", data = {'user' : 'a'*129, 'password' : '123'})
    self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_USERNAME)
  


class LoginTests(testLib.RestTestCase):
  def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
    """
    Check that the response data dictionary matches the expected values
    """
    expected = { 'errCode' : errCode }
    if count is not None:
      expected['count']  = count
      self.assertDictEqual(expected, respData)
  

  # for wrong user name
  def testLogin1(self):
    respData = self.makeRequest("/users/login", method="POST", data = {'user' : 'a'*16, 'password' : '123'})
    self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS)

  # for invalid password
  def testLogin2(self):
    respData = self.makeRequest("/users/login", method="POST", data = {'user' : 'wtf', 'password' : '12'})
    self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS)

  # for invalid count
  def testLogin3(self):
    respData = self.makeRequest("/users/add", method="POST", data = {'user' : 'wtf', 'password' : '123'})
    respData = self.makeRequest("/users/login", method="POST", data = {'user' : 'wtf', 'password' : '123'})
    self.assertResponse(respData, count = 2, errCode = testLib.RestTestCase.SUCCESS)


